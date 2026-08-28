# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d500fe0c968dfe38b20dcb9136fc7a5e22bc8053982a219708f31000ead5c4dc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1ea4a7207d0b9c61d6eca19ad7ffdf3c0b9bebf4ed0d93415ddf746189e0af10"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "660787166f7dbf4fda3aed748b06c14d013fbea78612182e8ef4e2fa4434f3ea"
    sha256 cellar: :any,                 arm64_linux:   "fa254636670027b7c02ebac5f7fae9e89e349c6d351842b2359437c0433b0e52"
    sha256 cellar: :any,                 x86_64_linux:  "0a3a68acf4ac56440c64bf3a4c58b3b8ab6ef365561c0fadee10b6694835b3da"
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
