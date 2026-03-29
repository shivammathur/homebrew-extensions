# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.80.0.tgz"
  sha256 "75e553f2b5c3f7dde99aa984a9601dce6db240bc3c85d7fe09298b5bd8c5d53f"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6f2338d6ecc86041d922945b1bb14470fb0fba42b4243c288ba74fb557a54069"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b3937c07329f7cc5ea8eb8d8ad397eb1b52a54d72778d45514c1c1b748e18f34"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d43f32c90f7e7313944689783e76994ce073a0d7c88b552f8e677dc9af5f53e9"
    sha256 cellar: :any_skip_relocation, sonoma:        "c0934c91191312e1026f9a83dec6b914dfa086e621a6a05a34f42ef414b59442"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9cca15c74ae933a57f602398b29384bcc6eb8848525de514e492d62ea69d3c0b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ac7ad48708fb5e886b2f7297401bb013ab6e178ea6e1dcf9d7a7a69f4a7b788"
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
