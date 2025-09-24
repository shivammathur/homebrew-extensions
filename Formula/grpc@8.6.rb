# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT86 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.75.0.tgz"
  sha256 "d2fa2d09bb12472fd716db1f6d637375e02dfa2b6923d7812ff52554ce365ba1"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "02bea1a43b36de90dc631b25c6113bd8c81fae8a1db090c7d992369790e18d40"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2a819a7ae1f3cf8d7faf706828398bc33ef9764bf9379318e3a1e40a2f8d7abb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "518f948d73608fa976e80d55da242b6fa575010eb5cee102d598aed5a6dc8170"
    sha256 cellar: :any_skip_relocation, sonoma:        "fbd7b6cb3a83f4d559caba83d8d3ac76e477854a5b0bae8111a8cf424a0d02bb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4ca965e63bc6d1e39cced616ac3089f81c021bcdeaaa3ba8013117e3a303777b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e0ee060f4d038fb9c250ac3ee71fda3bfcad29c96d10ed3c75b12c3deb0e05f5"
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
