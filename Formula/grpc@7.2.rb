# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "1bb69fc148940a18c7e0e07c67435d6bd0dd376d4db89de31e822e7516784a81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ab01cf1f0a898d8c59c1d4309f07a285182a9b130cf1a6025e2ea72ff4c69614"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "35fdca49d98369919b2c299b0c19b501d424296d7189625683fcd4f35b76023c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9873512a462a2695d2e49427f9dd2277d00f95eef590b36c1adcb23b38de64fb"
    sha256 cellar: :any_skip_relocation, ventura:        "69a2c68b36363b6dd5583bd52842a60b7d87927c1748d917ccb738ba1d4bbed7"
    sha256 cellar: :any_skip_relocation, monterey:       "aae04048bac8beccbfe9a95cb11d354815e5507bcc4f2c94c77cf4f1d2ba461f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "db9e98ed75473f39a3f120511322549ac5f156b46028e5483937633f897ca487"
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
