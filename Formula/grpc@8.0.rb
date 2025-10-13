# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f57668c8d77e6387b0d29d7a519c5c0ed36f49f8073b37a96973fc5215cf4996"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ec6f2d182fdf2e82fb991c3e47ae70c0ff674bd266dd72fcded9678c1eb5a45a"
    sha256 cellar: :any_skip_relocation, sonoma:        "4a84e36ea1b0b5a1c9526245b2e5e87b2b717569ba0f86a9cd8a4bd32cc5c956"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fd51f1c10adf7592d4994555690cff26330960e63c252f8ed40126f22bb69290"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b87e4c7ed7f085219f8b3772e6894dbc0ab2942120aeb279cf3cf112b0b8a035"
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
