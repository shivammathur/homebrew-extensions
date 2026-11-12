# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT84 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.0.tgz"
  sha256 "2342df367fb01a789a1b9f6c9c780f5221c51e9c00bf1cd1dd8a5c38b98d4cc5"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "cfece20196a08be9f591cd41613f5cfe256eecf715cc6ef2c86f934a19df4c48"
    sha256 cellar: :any, arm64_tahoe:       "c93ff9f04569e8118d96486a4d7507e6973421b63cd0a7d8ce8711a16bc9c114"
    sha256 cellar: :any, arm64_sequoia:     "cda2d56b6c19ec4fffebcc2f97cdc9eecf39d54182efd8af6d8ae5fad9dde07c"
    sha256 cellar: :any, arm64_linux:       "ff44cfe2adf3a666e9808040f6b2d7987900eeb02c7f8aee12b97a37edc46b66"
    sha256 cellar: :any, x86_64_linux:      "96ab979545cea9b687d778361252ae1556a9d0fbaa94c5f211718b82f4eff3bb"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
