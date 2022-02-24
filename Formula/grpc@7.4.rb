# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.44.0.tgz"
  sha256 "f6d6be7e1bd49b3aae7ada97233fe68172100a71a23e5039acb2c0c1b87e4f11"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3a09a09f69e085921999ac0bce896f5b80c76a7d1e537cb15468c7e3c0f2ae3b"
    sha256 cellar: :any_skip_relocation, big_sur:       "ea4438c138c5f0ec45d65d640a2765f92586854c8a4f8890fa5f7193a4065c2f"
    sha256 cellar: :any_skip_relocation, catalina:      "c13304351b2215c5d2668afb73528c1fe63c565740d598427df27804258e531e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1645bb8e7c50d6ac0774dacb8cdd844703b196ffd37918f9beba68c712820eeb"
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
