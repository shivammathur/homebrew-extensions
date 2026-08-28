# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.1.tgz"
  sha256 "cb06519b1382f57ba6f5358504cb37e933d5a5892553300877fd4f3b04cf0560"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c942551bad628afbbd31d93f4d139178f67dc16e96f31ebb403656fcdb421c54"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8b6920459ae3f1966436771bae7294cd2e333bd5a780d905f133ebe3e63dba58"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dde7ef87a381e347ca0549732118d676d2c1c98ba583be9af61b44a75a12ee85"
    sha256 cellar: :any,                 arm64_linux:   "dc918235dac68dd11780e0aa64f128daa4e7924712f3025f20d6816405174c84"
    sha256 cellar: :any,                 x86_64_linux:  "cffe66e05cd5c3db7e427615e7f2e7e76985b9a158fa9ed1d0ad1e9be6e55dfb"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
