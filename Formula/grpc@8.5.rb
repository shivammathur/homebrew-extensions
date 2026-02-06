# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "aa3da0838053a967e02efe27e08a94b56f0e228fac24eec6869bbbc05ef57aa1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fc16a6ff5792976770843ca1ba8a4b0dcf694a98494af8481fe993cc374f01d9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c298a0dc0b3e5bf3883c38d69c9cf4d4f87cb9a21b3568e9b25e8b2779ea6bee"
    sha256 cellar: :any_skip_relocation, sonoma:        "ac18b1e5fb9d9817498d82850d0f6e8ed3997093d55b3265748205eb19acbf66"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9f01f55bf06497bde1fe9027b08b7e33f6373c17ca2a368b012f236447a2d2ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fc99c7038c6205ca1ba15593a63e6b7b1cb6b42506d04be50b56aed0608499d2"
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
