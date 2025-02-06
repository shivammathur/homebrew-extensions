# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8ba9fbb47a1fb004df56e95476b12a5dd4d836eab5f67a93d8e08a23124d7bdd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a82c79891432d1433f3063fd85934d59eb06cbea198beb627e2b7bf444bc88e2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "281354667dd629a248514572d7e03f0e8573b65cf8535d3a37f5e8993f06877c"
    sha256 cellar: :any_skip_relocation, ventura:       "ff5afcd8e826aeb6bf6372af8ccbb14037c31e696d1b5cbfda7a0be4f2540231"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0785887688764071cf444baf870ab0bc61bbdbd10903745c864c7577407d5881"
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
