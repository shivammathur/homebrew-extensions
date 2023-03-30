# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "04036245e4d6fce23749d7b51769f2f46041d30683d5779ba739d8b509965d38"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c06459a901903cae8dc80aa9e7a3f4030f59f7f744119b932c78a34174ff5a9c"
    sha256 cellar: :any_skip_relocation, monterey:       "1ab14b96b67b0d29822cc5874127434182123a5057b5f5183ed861a9e5df0e31"
    sha256 cellar: :any_skip_relocation, big_sur:        "573da05bbd4359cb8f1af0c54e3977f01d0050d91961785d017856c55449285a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "40ba54aa94e9102d4d9a7192d2414d1272f89d5ef994f57b076e60a0440c4624"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
