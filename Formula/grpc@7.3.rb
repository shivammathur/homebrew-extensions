# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.82.0.tgz"
  sha256 "bbcb83e229b565feac351bd88bd80091c4ef613357122fccf8a9930cd988d6ca"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b9344d7854059f2241f7a3f1cffd7d2a62d134eecc313b2a33410100c5b492b5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a8bb320dee08be18f8d8f50bb5a360f257045ec1e62638ab923ca2a07e9b0272"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8f456521ab7f5b2788c085e3a82d772e19c218cc3ea94fd61be4de53ee5421e9"
    sha256 cellar: :any_skip_relocation, sonoma:        "afb1c9a5c8149d88b6e6bcd5a0175f6a76629289a28098508383b41ffdaf8b3b"
    sha256 cellar: :any,                 arm64_linux:   "90486a5ea8be840eb8f8570df4acdf0ee641694d46027fb7fd66ca1ff6a9bb5f"
    sha256 cellar: :any,                 x86_64_linux:  "2827b4c733e056655021b6203a558f047d604ceb79f18f87f5042e079e81b262"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
