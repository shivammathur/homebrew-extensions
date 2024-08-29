# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.66.0.tgz"
  sha256 "6f6b751bbf33a88f917ca11a5b32923223c106eb5f064b791f99c6f7a9c7e7c2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "367ba15eaa16ec9d0da26ca3d0ce6766d36ae50a55b2a284710aaeadbc5e52ee"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6db78bef733747503f5580c0d353a588c4375356704e8a21ac0c34e4caa7db8d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9f57f1596fb08a73bb50b4149e794904c50b045898875397a5529ded366cffb1"
    sha256 cellar: :any_skip_relocation, ventura:        "601e287a98b6c9e5c699cd7f1ae466ef810fa89b5c462f12dbc3640e7bd19d3b"
    sha256 cellar: :any_skip_relocation, monterey:       "06c6957609e75d37611ffa08bbbd9f8879e21f7d2da1af030728af6add3b0430"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5a1fcefaa0786df02b690537b1720548f675b55a5144dd1eadb9ceb49c4c4285"
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
