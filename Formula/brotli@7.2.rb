# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT72 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "f5173604b12b1db3b4994a0c3601ccd327c0819d80a32992fe866c88776642d0"
    sha256 cellar: :any, arm64_tahoe:       "145988401aee9f7eb2a84ed3725c9d065b4560d55fcd1ceb57ae4e9433d78981"
    sha256 cellar: :any, arm64_sequoia:     "4aeea8afcfc3716562082baf59d269ef27a5c4e4fe71fb3ccf3b6541f680dfe8"
    sha256 cellar: :any, arm64_linux:       "f8a5d4edc6bea973d956e056aaba2f9afb793c054f8b51170c52230c173353a8"
    sha256 cellar: :any, x86_64_linux:      "5f373e7f52db2e1bbecaf387fccc520f0f7049755c7d2fe4285a6620f08a50b7"
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
