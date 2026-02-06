# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e8b27040c35d47accc55f286c719fd45b090b807222834c1a7dae0aaeadb195b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d782c66787d14b450719382fe4afa772422371f05958b35801993a0721409720"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "968425997479f4a1eddcbf3b3249971995ef0b475c11393daf6a95e344064818"
    sha256 cellar: :any_skip_relocation, sonoma:        "36f21a595796acd9906a76df8f8a740382b9ee2d505885ecdc54f6ace5cdb141"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "55292b445d96de9be1b58a8a030d2b222c13386a2af4b863d616678759e52d47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "00f85794327b2c3ff59f7e37c9a40695d39dc19eb5e05dbb8d5985e4077eabed"
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
