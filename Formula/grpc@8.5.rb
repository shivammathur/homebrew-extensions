# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.84.0.tgz"
  sha256 "555716233a5cc9a6baa605719f87b7688a88fb8bfdd9b4493396276244d56625"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1c13bf15ef674e3d3c667c3bcd0ce15b080333d3d5aa398c2131ef31e9df6490"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fbdea133d6fbb71732e00340b5c0ff349bc70f0dda56dc693121d7ba70f05ebd"
    sha256 cellar: :any,                 arm64_linux:   "037c763360d74c286a1ea3b52409dec074346f6ea1e3f387e14721519e3ba332"
    sha256 cellar: :any,                 x86_64_linux:  "f870ea82daab1f0bafde7b5edce89f760c79c14ddbdb8ccdd3b1406f885b2776"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    inreplace "src/php/ext/grpc/call.c", "zend_exception_get_default(TSRMLS_C)", "zend_ce_exception"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
