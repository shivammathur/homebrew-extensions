# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.0.tgz"
  sha256 "adaf30db949767bf0ff5a5308638e4b9bb5f711733204ed5a5e8f3014d80a174"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f813399c3cc87c31b1c69ec604fca4f233e353fee7d44fd5a3e13f8ecea72699"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "809b09331fc9fc14bf216a0353b88508dde46d01975689e496d2c10477ac03c8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "27fb408a96df2562d8f94f3cd55975aa6bc300a2117857133d1be85a6df6e5d6"
    sha256 cellar: :any,                 arm64_linux:       "d9391cf465f072d18a1e33a805bc77a4f79533bcfeab4ff3a170d726ae5e1d18"
    sha256 cellar: :any,                 x86_64_linux:      "4dcfb9eecc6adf85e769825cbbcce366e42903091689b6916db5093fe62b6777"
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
