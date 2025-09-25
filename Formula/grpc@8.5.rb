# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.75.0.tgz"
  sha256 "d2fa2d09bb12472fd716db1f6d637375e02dfa2b6923d7812ff52554ce365ba1"
  revision 1
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "10a06d3638ad66315fe705f59152c678546327e9a673c7221271aa5ec2a35f13"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "09a34e977c8b7f8744514549197f36c70425ae26b6f64f64c9f640fbfda8b2fc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "030a1ebb57904b45c6ec310374dce38bb30b056bed682e1e20b66e64422896fe"
    sha256 cellar: :any_skip_relocation, sonoma:        "b4df79708b0f45f41b462ee12c59b1246b1df766e089c89e05eaf7e278fc2c04"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6fa6916ecb93e225c7a874e08f95b0789a92db688d268f1ecfdadb001f818609"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "09cb6a7a798e7bdfa5fa0700c0bd79b2d39d1ba674fbb3b0e0432321fa978d09"
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
