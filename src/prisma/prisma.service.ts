import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '../../prisma';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  async onModuleInit() {
    // Conecta-se ao banco de dados quando o módulo é inicializado
    await this.$connect();
  }
}
