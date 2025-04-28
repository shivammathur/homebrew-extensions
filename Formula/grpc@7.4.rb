# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.72.0.tgz"
  sha256 "715fe230c0b185968e92f8f752d61a878f9eb5346873848e47ff65d0af6947dc"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "83a2e0de1ef75fd119991b2c758e8c77360c97ab620e232e4c70a1e20c31a7df"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1568c7e53b4f35c8be9f6bab9f80561007afd9f1ccc4303c779b2386575cdba1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "57fa4f86e24433de2e7169b7c391b945ef8c810d8c590743d6e11c76ce20a1a6"
    sha256 cellar: :any_skip_relocation, ventura:       "e5ddf85132e5aae1d3ae6b8a86a6b40e3e5228c57c00c3210910d536e19d971e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c8238a92a241ea68c112eced5ce58b562237e07b8553a466b8bba12edab8f5ff"
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
