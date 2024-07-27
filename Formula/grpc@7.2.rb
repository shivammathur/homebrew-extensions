# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.2.tgz"
  sha256 "5efbfd399f3be464e293bb0ec4a773fae9bb4a43b67362e1fac72bb4cae4bbc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "16c20bed23c82d937d0ec60fe3058c32fb21247569ea6b5b2fb70f01bad7415c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a79f3931a1b4f1cb2acf5c41d7a99fb32fd3210be627e6e7abd3ec809eba931a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bec51cb84b7ecfd0c24c98374e77eca2db4ca0a1ed9360d648a81669e4918074"
    sha256 cellar: :any_skip_relocation, ventura:        "4c4595689238367f2a759cc070e7cbeeb2f49bee20323c90dad8929e0ed7c28e"
    sha256 cellar: :any_skip_relocation, monterey:       "545c53a89d9857871d5f306241a88b02ec4a8993aa083bb2b696516f2459ed97"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3df18ffd03ca020b2f6ba4416426a0caf21f5540187dd952e76ca42bb2f35ca4"
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
