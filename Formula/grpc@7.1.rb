# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "683e1eba9bc8032e64963e605c5d678d03e157bcf10120093f9a1f22f52ac873"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9994800a8a7a1d3ff216a2c762e3d3ee42883368f8cb5e85be7eb09667636862"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7bb7c8940e19c32b1e09b4b7a0f3642d4b95483e292d0c1b68ac7fcb72045c08"
    sha256 cellar: :any_skip_relocation, sonoma:        "98e6715884313c0736771d743530a786aabec25f5b3b291194f31d229d7574bf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4adeaf7781821d28d3b273ef36e62790a2b2de06b0fd289bc05511a8500fbf8d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ec912c1c5eafea1bd6fbb079964b25cabccd84bb68c694a87e566d21c0cc91aa"
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
