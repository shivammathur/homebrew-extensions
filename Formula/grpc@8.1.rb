# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.0.tgz"
  sha256 "4b4ccb491355f938d28e63a476df92d5109263ea63ffee1e0249616461e26963"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "740e2faf771eaba8026c326441b5a4c5266215ce49676bf5bab46cefdb5da180"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b9f34aa6482ed75136c2f66467d0c43cf5062a842cdace04fca2217745b9c962"
    sha256 cellar: :any_skip_relocation, monterey:       "2beb15e54844eb77803547db17637fd43775d72a25670e343eaecb2d09c40905"
    sha256 cellar: :any_skip_relocation, big_sur:        "38faf2f9d6593e3efff4204f08e80541df68d94cb7994786097c87d016b575d4"
    sha256 cellar: :any_skip_relocation, catalina:       "61482bfc28c0e3c7249ea530f17ad2cf0896c6825cadc0c2bd93e2dc3a8431a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dcd5709a4f8db8105be0a593cc17d4bb96363a941fbcef143713ec456cc0347b"
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
