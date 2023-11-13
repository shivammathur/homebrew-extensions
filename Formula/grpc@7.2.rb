# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.59.1.tgz"
  sha256 "d789aab7c791647907c3bc3af2bd6b6e97348d1b50eaa59826be61c4a3c3d3ee"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1766156677c624b30cfc089f049865085d8c61a7c51cf6262fa90f72e4a217ab"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "23aecd59ce666a69ca37c80f2296c0e71884ab875f36d64f1919b5a6b078d73c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2d4cb49d30d95d907be0ed50d24ec3910a136be81fe90744ddddb1b3360db3f4"
    sha256 cellar: :any_skip_relocation, ventura:        "42151cae14f4d877c7a67e05a8dcb946b41ed1fd199f54473fc63a23094f4cbf"
    sha256 cellar: :any_skip_relocation, monterey:       "54d5370ff46f313a368ae48d40b44bcb7e60491539b744b8f5ef8572cfd4896b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "545aa5dd057a450cd2eea4cae762f750686826c912a67eb5a534d2baf4f5bb78"
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
