# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "683ab50daa1ace4f1cf7cbf18f20e7518682869bd24fdf0184cdabf84cfd19ff"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d88acb6da8d2706c8acda10e44e34bd1df504ecb8818186ab5e6b0da6a871fff"
    sha256 cellar: :any_skip_relocation, ventura:        "449a380867a9a9b5065a5e00a76cf3024e76b022a6f1c09bdb2a2ba4ef3b4f13"
    sha256 cellar: :any_skip_relocation, monterey:       "5332394b75f64342ad305a10914759a86c2707a5bcd1e6fca120588cefffd0ee"
    sha256 cellar: :any_skip_relocation, big_sur:        "16d9b27d15de32fff56d45cc9ad46fa86db5e040ad2297d141d5353fc1099078"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a658122db0b770baccca6d9ad9b22119584f6c966536a487a06b7f6f035ebe28"
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
