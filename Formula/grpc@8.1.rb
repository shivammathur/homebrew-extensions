# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhp81Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.36.0.tgz"
  sha256 "819becd24872b95c52ad1f022ca71f6f5eed207605b19a26e479b1d5a62c8561"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5c9118667e19e10140028726373b73ab388f990bd4745ac7c661326636d7053b"
    sha256 cellar: :any_skip_relocation, big_sur:       "cd8c04a102d2c7c5633c727cf7548adc0f984b8ba1c2170e5354ad7978081452"
    sha256 cellar: :any_skip_relocation, catalina:      "34cececc2888f6e31169319134aa60b2abba4cb62572ac4617fb04460c27364e"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
