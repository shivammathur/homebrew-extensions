# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.56.0.tgz"
  sha256 "bb3c58314cc4c4c043b70bf7162a4ebae507834bf5c2a014b67ebd8d70109dfe"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "66bc49e00a2cdbfe51c9b3fa603f4956e98ee857ae28e5b3264cb7640f067e2b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c72c2e2887269b319f82d0b0a89c5e2393bbd7560aeb5ed6809d3dde8577d8d6"
    sha256 cellar: :any_skip_relocation, ventura:        "50c2ccf4ebe5679a37178cd7c04306b158aae309e26b5e5616aef33784699d56"
    sha256 cellar: :any_skip_relocation, monterey:       "5993a23b67e826158c454ef3ee0936140d26122af1d42e358f011a9041620b62"
    sha256 cellar: :any_skip_relocation, big_sur:        "2985871d3142d73fcd42f024a42f2d2fbc852e29b1b6ab01b6f6705be911b341"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "704c238dd729f6af4f5dad3f9817efe9e177c027ac0930b8b0eb1eebbe3c0f25"
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
