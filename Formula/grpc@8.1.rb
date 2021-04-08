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
    rebuild 6
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "66f80b04b420a4d79959acae6d10612831afd5872916d126bde0eabc1349892a"
    sha256 cellar: :any_skip_relocation, big_sur:       "6175326560a195c43283eca3746032c9fdd71bd93b32d056bd4fcb451e9cc304"
    sha256 cellar: :any_skip_relocation, catalina:      "4a798103daec3f5e21de432c01aa01b69d31745b6367ef5c7144a7a61c4f4871"
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
