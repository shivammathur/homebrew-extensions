# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT73 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.1.tgz"
  sha256 "33574094e39a433ede3570ba6fcf15d356fc3489abbda396f8cdac472338e1ce"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "58aedabe3c7612905d5a9606cd46d308f4a83328edda9f0dceb52badc902f99f"
    sha256 cellar: :any, arm64_tahoe:       "e29cea476ebc42a0f88a95ec2759f24a4802be26ddfb94099e4d56534d0e71a0"
    sha256 cellar: :any, arm64_sequoia:     "0ec22e18f906fe96f6422a59c6df9e8447ab9b86d3ffce11b9c5d7f41b5d9e0a"
    sha256 cellar: :any, arm64_linux:       "383392b4f75be61ffffd52afdc7a8338e58edcf2b64d095f7ea9689e1eda748d"
    sha256 cellar: :any, x86_64_linux:      "9367b95fc3152b14c976eb3f4673be183c166f062cc8a9b51dbd4eb27e6a9206"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
