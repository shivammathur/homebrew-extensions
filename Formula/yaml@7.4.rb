# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "e9438e59bab4f3d561fe72b0a37ce7f8234259a4a636eebc478a10b35521fac0"
    sha256 cellar: :any,                 arm64_sequoia: "bdd8478314f6b97899895dd7e0be21d12fb3a2346b27c9ad090708b4f8a064ef"
    sha256 cellar: :any,                 arm64_sonoma:  "83bfde5dde961aae670c57e775951dd1fde3905fa6a88f74cb225bcc4cbc3891"
    sha256 cellar: :any,                 sonoma:        "f0c402e5c4d80cc9f306b9a89ac2e434e415d2e5da4ec2acd330b8201b94f2f2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "21956722f2ec7823f08f4d8fb1919e2ad81c7390baebe14c5dce6fdb4c58d18c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6216b77d9acf66eebe4ab668d1d01b4407fb51d5ea62535f0fbc824605a968a1"
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
