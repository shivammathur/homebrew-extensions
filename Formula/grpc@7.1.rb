# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.51.1.tgz"
  sha256 "a8a79bf27bceeb8088c2a3a5a76c1146bbbd3e8d7a8a13e44ddbcfd715213ba9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "82f813ac869a023389fef79974de4de4b382cd50665d1ba60e3ce5ecb481394e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "bbb6ea51b2a8315de7075be91ff10214f9b65b2a59546ed17a7173d20b031a84"
    sha256 cellar: :any_skip_relocation, monterey:       "92ade32d45163e4a5fdea7a1c4849e7e1c67c7019cc4a62aa2d2849185d8be8e"
    sha256 cellar: :any_skip_relocation, big_sur:        "0f98b9c18e8479af7fa023f346ac96f7f318d2696e49d7de2f078e8e92f3bafb"
    sha256 cellar: :any_skip_relocation, catalina:       "a1cb1c2c27f0fca05fc3c2d2e302eb49c7c7f5dd5f695b953ff2e8cbfc3a62b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a358a9fcff989a958d35023943a4a124a4f7432914a513a34b204637c30def36"
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
