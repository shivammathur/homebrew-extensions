# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "091dc3298ab72cdedeae66d3c05d4fe408677be1b915a978de331c4a5676ed3e"
    sha256 cellar: :any, arm64_tahoe:       "9806fe17cd32c0a8715097aaf99cfbc93e0aca5f1aba9cd06cf0c00478ef2a8e"
    sha256 cellar: :any, arm64_sequoia:     "a694ef9880dc63a1cb1e665391785ebee3132425cfea3500305c727d28a8ad3e"
    sha256 cellar: :any, arm64_linux:       "8c25eb1637f402b0d5468ac6ea762f175e41fa1eb7aa1dadb359d7a4bc7b00e6"
    sha256 cellar: :any, x86_64_linux:      "75f6b1ecd73709ef41837ed31a8de7242f90f3c9a2ab17a0fc7139829d2e9c2c"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "#include \"Zend/zend_attributes.h\"\n", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
