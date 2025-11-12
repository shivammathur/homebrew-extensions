# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT72 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.3.0.tgz"
  sha256 "bc8404807a3a4dc896b310af21a7f8063aa238424ff77f27eb6ffa88b5874b8a"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "cde05557a1211c4355cb6db1bebb406080220f41e0b99f7ea96bfa0ba67292b3"
    sha256 cellar: :any,                 arm64_sequoia: "fe1f5b88802ffdc44f725f09644c2076ed8c1c7b530429fcda11992555a741ce"
    sha256 cellar: :any,                 arm64_sonoma:  "2cce85007952013b6609e8d9329dff608103669735015fb6292d8d35f25c8eac"
    sha256 cellar: :any,                 sonoma:        "df6407c1571833f5c20465886548b4a33910e898ac6ede605166b1d0b7b4d1c7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b5e4c5a39e17c3681779ca545f1b4476edad2740b0d118b7616a49108eb93df6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ac64ae811868d6a58f1d43f8078b51f0befb8e638a2ed0ae07fe51a1e7ad6cf2"
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
