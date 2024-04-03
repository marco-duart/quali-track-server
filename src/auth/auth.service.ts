import { HttpException, HttpStatus, Injectable, UnauthorizedException } from '@nestjs/common';
import { LoginDto } from './dto/login.dto';
import { UsersService } from 'src/users/users.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}
  async login(loginDto: LoginDto) {
    try {
      const user = await this.usersService.findByEmail(loginDto.email);

      if (!user || !(await bcrypt.compare(loginDto.password, user.password))) {
        throw new UnauthorizedException();
      }

      const payload = {
        iss: 'arnia_cars',
        sub: 'users_auth',
        aud: 'arnia_cars_users',
        userEmail: user.email,
        userId: user.id,
      };

      return {
        access_token: await this.jwtService.signAsync(payload),
      };
    } catch (error) {
      console.log(error);
      throw new HttpException(
        {
          message: error?.message ?? 'Bad Request',
        },
        error?.status || HttpStatus.BAD_REQUEST,
      );
    }
  }
}
