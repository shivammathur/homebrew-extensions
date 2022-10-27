# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "411db3ff30e8a262433ada9d80a8363f9578b742ac37cc0a7665dd53d6ec45a2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8906b02115285945ff8f6440c54ab268742bc552aede6ca860c572753810033d"
    sha256 cellar: :any_skip_relocation, monterey:       "acacda50be0ee4797123f92240b2966ba9476a9e25ed763d976dbff325e0fef0"
    sha256 cellar: :any_skip_relocation, big_sur:        "9c6bd0cb259b22604ac69723f15f5854bb779ecd119df23b71b7a4c14bb7a148"
    sha256 cellar: :any_skip_relocation, catalina:       "74310353215bc3fba25b53b6ba4a15ee46bf9fafde56edcf5db2962fbf6f39ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "592af478c5cd6cd5b73740772a2e5d3c7d177ef9c269f802d4523f951fe2fc91"
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
