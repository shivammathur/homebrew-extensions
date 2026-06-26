# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "da3e39a2013a456c42198e0afb45614612e8f8267416e1b5be0bd7b0aa0d0d2d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c9e174c46c18d141db0c31e5b7c9009de8c39857c605039481381d65e94484f0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2aea5ba9aab103c39c50c40015e93fd093b0638d74bf6063b92547247201888a"
    sha256 cellar: :any_skip_relocation, sonoma:        "5eaa086be90cf0709e0880e4773272fe43b13fe88e35ad9cb83a59078d69b789"
    sha256 cellar: :any,                 arm64_linux:   "39196c50e9076b5b27da4ec6b8bc22f7a92a9d6fd3aa7d44d0bf3b2b10c31ab8"
    sha256 cellar: :any,                 x86_64_linux:  "740de514b765c6c8598eb85ea8d16d99e7a23b9ce884a313ebd72fa778ebdcaf"
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
