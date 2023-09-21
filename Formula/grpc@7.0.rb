# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fb58014250cc71e9d46bae29581b9bedad49bb5fdbf2b8d3857c617529ac2464"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d3328c9c303beda580a7da7e705ee3954708b805825886bd4de7374b696fcf5c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ccedca0390359c8a665a3a5e9af2fd8e406219b53d5f192ca74dc0225b456fb7"
    sha256 cellar: :any_skip_relocation, ventura:        "e570696b3e155e03bc9784d46d4691f0aa19a814ba301ac705f6abbb5a900e59"
    sha256 cellar: :any_skip_relocation, monterey:       "9e380d73513a7f66739a2ddceab22036709d2c8c5c80e1811c666b6bd6608b3f"
    sha256 cellar: :any_skip_relocation, big_sur:        "088b470ba06560b8b13d35a517c8082a9df7bd84fcd3791f115df48560d2c978"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "843ef6f43216f09dc990589f021b095c69e01e99bf82c948dd4a2f1c77de17a4"
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
