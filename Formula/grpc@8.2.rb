# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "175bd31b7396710f38d77a2cc44d0b1b4b1bb518bafe02369873475a524b5fbe"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "ea08d9418056ee02f6b6769b56970fbfcb9275a807309ad64bc0d138be3b8a0d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "8955d058169e1615fccd0d4d37f017bcc7935dbd6ac97055145b49830fcbe67e"
    sha256 cellar: :any,                 arm64_linux:       "e41a6c2309b1f999a04ae5c69498a7275483741fca98ae5eebdb9b487fc9d9ee"
    sha256 cellar: :any,                 x86_64_linux:      "9e64efc1dad22a33dd54f54ff10ce3ed930c5e4fc905f35b2ed3de02ac77534a"
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
