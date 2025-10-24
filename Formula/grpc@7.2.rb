# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.76.0.tgz"
  sha256 "6e3d65695bb99de227054ae6431cee29cebabdee699ded55e97fc6f892eb4935"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1f3e1b17514e8b1ae411c27a005ecd67eb6a38f9f8f4811eaf1192345eb82534"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "77d6e8d62978980710b47c5ecc011e07682c6093ab5e3f3dc25a7ba98f2c3645"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "094909fdd012b0a62a8686b4804e575a0d37c8179bc76f217f4fc5c8347abeb5"
    sha256 cellar: :any_skip_relocation, sonoma:        "007bcaf3ee66f04967f75a9e07acaf119b01a6ce766e66ad0c75b54e8d4c8463"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2cae9c0c0c4f7e847b584dacb3ee1879e067c0cd82f23b75119f8c0c22b1ff5c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b1d4588bb52f7ecbe5a9f08089c2d43ea4b88387e06c2c96aa099ed1a2bd435f"
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
