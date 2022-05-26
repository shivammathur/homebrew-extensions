# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.46.3.tgz"
  sha256 "2aad61230afda3192eedad25be918bda628e6aa18bf1ed7e3bcf1944e6e4f4d5"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7d5f5aac6bfcb3914cd7f3a75d259013ed161bcf96efed7b5ede06436c86f1a8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "aed75b67abaa5cd716537c8340360e32d1323de40ecf389179db1b98f1bae1b9"
    sha256 cellar: :any_skip_relocation, monterey:       "04b96ef97878020d4efaee8e79253b9e6f368324d201933f601c6a2377cf7d42"
    sha256 cellar: :any_skip_relocation, big_sur:        "db673fdb6cc9faee874b4ea3bfbf4cbfb2551f2405969ea5e851ed997b23f666"
    sha256 cellar: :any_skip_relocation, catalina:       "9fa6923a597aeda075b364e6b45b0561696eb123462dc04ed8f992b7ec14d7c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c0e1ae06655ece640e1451cd7615b52b25dfdc2c42307a2f44e5e5149f823c87"
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
