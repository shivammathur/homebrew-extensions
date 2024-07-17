# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "89d4d9290d852191a86b8a1be8e869fa4e86e7129dd431f9328e8e776aa13e4b"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "89ff1c8e9c7c6803efadf250be9b08a00016f90640df4cff703cf64faff0e2fb"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "53b09a45bee26faa9c97b2253ad5e984c6201db35fbb8ab232ca51de58a1b252"
    sha256 cellar: :any_skip_relocation, ventura:        "5e381a79bcc4c2b3aad3b97e5a08973ee7499f2e4c15f998473b8466c3f62a36"
    sha256 cellar: :any_skip_relocation, monterey:       "c496f2421065ce70e43c7558b4f3e9c5a97682357cc9c030058f0125806d1b7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f59b85d7c8a05313c8506ecd97e23f164e9056409cf9f7d2e09677351bf22d40"
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
