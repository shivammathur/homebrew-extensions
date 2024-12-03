# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "09d7117b7dea15d5bd70618433c8d4a6400f58b34a98d1766a86c042e43a1e39"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "80f67baf8f17a7a474ccd51ab535d97820057a3a522f327bc634eb58f12206e4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "989dd18b6a1d700f601f4ec9e50c5ef56144261b2dc9cef3c33d1b88396e01a4"
    sha256 cellar: :any_skip_relocation, ventura:       "9be12cd28f0fd65b229945d792a6d68c5d0324dfacf0dd3a798b906d7d76a6f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ee7ae79b4e8529755afa3f9e21d0246f6eb96aa37e23ed8d8b9163d9a08349b8"
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
