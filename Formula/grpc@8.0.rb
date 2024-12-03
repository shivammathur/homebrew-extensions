# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "f208fa3598e387d5124bed3c85f3fc1f822099539538f49694a98cdbb1a18d2f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "0d873040915f228931e1df8f03547dca1424e1640fca243416601e322f68674b"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e4f8070c3acb450f737ada8187a165d6261a052387caf486ad475056cb8475c6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1cd6be810fa6feb46be71d03128319c0c3ec98886b9e27d2561a98754d3300c3"
    sha256 cellar: :any_skip_relocation, ventura:        "5f0197e44048a3e9514934c588716621a0a75c82174813ac262f22163d40bad8"
    sha256 cellar: :any_skip_relocation, monterey:       "d49f4c53f07e881a804ee69172e57555d1f45e469b327aa65980b261e1e6fe8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "04ca96c08535773023836b414a907c04c03a8410e294671d3236e426e7cf9f3c"
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
