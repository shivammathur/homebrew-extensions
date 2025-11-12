# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "a2a0d8b6f9f8837eeaed8cbc4ce0745af32375cba158312a82e7103e37c607f0"
    sha256 cellar: :any,                 arm64_sequoia: "37880e0ffba82dc285ce74e2955156fe67a836a3e4b37acc32d6b32290758bf8"
    sha256 cellar: :any,                 arm64_sonoma:  "419197d7aa3031d0a228453d49994f8f46dfd433630ff4ea834488852caf876b"
    sha256 cellar: :any,                 sonoma:        "65b02c04c9610ace77f3abb93791a7078636ac345b347ca9e9aaf90358cbd20b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3cf2845c5e0fc73e5be407abb7371036f401ccd11ff458bd8d92d3753c52f8e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3284828dcb6cb7a3f6a41c6f269e4b6ed8cd466bc75ef82925b0a9970a7b988c"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    inreplace "detect.c", "ZEND_ATOL(*lval, buf)", "*lval = ZEND_ATOL(buf)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
