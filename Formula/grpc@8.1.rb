# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "b78a4a689e9bad648ce263d16c8f95477f21fe871bddcff377ef05e44a8e3083"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "74555fba2ae38e628e15bfa6dfb50c4c1b056e4ade10bf2d78e3a9ca2c59e40e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "86d403b163c32f47c183747ebaa2bb541f0ab1d97ff17a703d8c51171d4cd6d4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "227238877088b2d7a26a22625455180ac3ac3d74f3aabd41e19362f84a03702a"
    sha256 cellar: :any_skip_relocation, ventura:        "59315e0312f6cce93cef6a67f268705af4cdb0ac134f6709cd9896239465ce51"
    sha256 cellar: :any_skip_relocation, monterey:       "ffa9e767c30ee66f66ad194db16d04d23006c8dc6568d519f7932ebece9c34af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b10103c866355d82e2f7b1578f07b61d9662269e73f3a50c93f75af798da031c"
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
