# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "2218a396d3bf57c4b22c1b248d327de181b8ceb4df8aae67c54df3e4dacd6f2e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6f506cefd12451d399ec83abab11e3755048207881a353faa1dca1dacedd3834"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3685c1960114f46cbfc3f37254ec2e70a1e5bb7973f5a725a70550564586b4f2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "34d3dc16b0474079bbb68ce7e5784f26bdb8d173834783bbdc1af654c6cca1c8"
    sha256 cellar: :any_skip_relocation, ventura:        "cb7317cf4a4ef3079fd2731d753797a1e394bf13cae5cb37147a187dfb3f84b5"
    sha256 cellar: :any_skip_relocation, monterey:       "4b9ea537a4781475806498b1a693bb1994dfecd6c47d15aff7fb23af3b0f5523"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "677f9e0def5221faae4e17873aa15677a51d48746c1bbb6de9e1b6d6034c8a7a"
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
