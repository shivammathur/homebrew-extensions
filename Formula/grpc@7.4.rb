# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.56.0.tgz"
  sha256 "bb3c58314cc4c4c043b70bf7162a4ebae507834bf5c2a014b67ebd8d70109dfe"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c380f19675000855b3a3d1e15ce14a3e50937fe6f4a1cc61f9a2a7348343ef07"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d72924942072b5e58459e1f01373c0db18283e861d80c1e5464c568a72cebc1a"
    sha256 cellar: :any_skip_relocation, ventura:        "5a74fb248485b14ae4617984b39f963a9c81c1374c536d1dd89d6dc395a0e6a9"
    sha256 cellar: :any_skip_relocation, monterey:       "ad944f0b5733c23cb7a464b975aa7dfa4433cf2c3d7933100b10ad4e9df11f42"
    sha256 cellar: :any_skip_relocation, big_sur:        "635458f6f6b972e7d2ca178d8bf6926558903056e7fe77700e1620417d779e1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "69e65379f386040ef51cf88e74d06c781dadb9f7eee1f71f694f43ec0d142d83"
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
