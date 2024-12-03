# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a3d31f39c11c7b82b33fc3a87ba73d0f923c598d62eecbb779b341192fb9be93"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c62f2343c072e0a42a00cbed8e238c763c0548cdf68b9b02d1595acbe70b4807"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "53ed914316fb64331b7de42819eb0c46303f923401264c5a85a10ee51b9816f3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dc32a3db1da9213f1fbd56b50aa412bd8f32d469b922c477db60c3e5eaf0e5ae"
    sha256 cellar: :any_skip_relocation, ventura:        "0aaf4427505a3b252c20bc26def16f0e55d7111c06ee0c18cac431ef3341ec03"
    sha256 cellar: :any_skip_relocation, monterey:       "8047ccc037a72b77e463f92c82809a4195e8f67326afc26914f66c2ee14564a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ac2b065487089bcc6ebec03c7755f3201d33ab2847c12db4eb9f7f0ec4ae1027"
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
