# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ed56ca3621897d0a12368b2007d14cdc75f06402abc63cf2d260fc8fcc026b78"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ac74df4d03fbc43c4bb26a323d2688d8628cd00cd1debccd599631c9b46eba7c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "011a9a293b4adc7aa328b0a258bdc759e1958367f7d37b3ee70ca7bfd9334b23"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b46f0279ba3c88c765b48c5d7d5a852e76361ff399b0fe6ee4955c89ac0ce474"
    sha256 cellar: :any_skip_relocation, ventura:        "3948ab72d2c72dd2b0b80f22545ef33af32190df91421ad5ec5530bef75245f3"
    sha256 cellar: :any_skip_relocation, monterey:       "9ece7716b3b94cdc29b6af29a7b2b6deabf4503d79811b7221c04eb15720e91e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eeb2d4d422569ac95f875e8488e17baae62c99901da6446cfa30516d496f469c"
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
