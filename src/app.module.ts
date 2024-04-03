import { Module } from '@nestjs/common';
import { CandiesModule } from './candies/candies.module';
import { UsersModule } from './users/users.module';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './database/database.module';
import { AuthModule } from './auth/auth.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    DatabaseModule,
    CandiesModule,
    UsersModule,
    AuthModule,
  ],
})
export class AppModule {}
