# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a2df6af7512a5e96f10206a3192953c1d4f281374b048401f499f27cd2e51599"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4a731e6f2b80f1f8a2e098cd841fba791cb3e7d97ba1ae8dc7a8ffb84d065e17"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dd042857bf8a023ea60cd2685d546adf749767767fd01057ab5ed7c2c1b04851"
    sha256 cellar: :any_skip_relocation, ventura:        "fa836f87455ab0490c1b8e2b00b399db4bb8564f1e81f8f2dbd4f051ede14884"
    sha256 cellar: :any_skip_relocation, monterey:       "e174cbbb238feb3822b3a83b9f65029ec8a7d8c6a5b88b0f8032eece997e1108"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9fe87034cbdde60a7094d355801dde5f98288bb79c69103dffcfe082afd2d991"
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
