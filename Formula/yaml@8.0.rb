# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT80 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "0f4f727dd9f06b7c7252ddca84b9b5bb376cd02a0c0c7b69c190dfba57a0af65"
    sha256 cellar: :any,                 arm64_ventura:  "39815efb07d157550d3557ca3373ef03997915586cd9726402ac94fdd54e6740"
    sha256 cellar: :any,                 arm64_monterey: "59e7807f86fa7966d53b4079f200befd521348cff444ee0bf9495f06b08eb639"
    sha256 cellar: :any,                 arm64_big_sur:  "63b37237e10b98f438d3b4fb928c3cce8a7dade82047e49c445c65d3d6ef83c5"
    sha256 cellar: :any,                 ventura:        "f05379d61fb995ba964285423824473168fd2062b42dbce17cec6c169b0a029c"
    sha256 cellar: :any,                 monterey:       "6f33e4434d274bd779d4c1e49edc9d3ab5bb9a692bbdb57659d4f6b874197ebc"
    sha256 cellar: :any,                 big_sur:        "b1c4a4b70b997c250906f79d0e177c53fea4a428993c5ba1c0cbf8b7b3d9d95a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9cc8add51bbb4e026875666af27438dcb9c8f23ff0f0a95f06de4040483c7cde"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
