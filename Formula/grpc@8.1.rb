# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9ca199a6c1629ac71918f433d11b14adb0731d47a661b76f41a19f430ee93456"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c019c9af1f6228d609be0350fd6ef66051d28929f2bd6be2b522c59c81b4270d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e5b3ae501d515f1e9af4824852b32f238f6979936d88dc96043a59b2a97bd49d"
    sha256 cellar: :any_skip_relocation, ventura:       "2e2cb5b42fff964763797d48b8f0c2839de81d5e5f91de42a075eb104d3076e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e034798a7d28cebefa6a50d59738676897703edb7438d644e07b1c04deb5d664"
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
