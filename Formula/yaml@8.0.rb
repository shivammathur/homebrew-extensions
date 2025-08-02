# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT80 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.5.tgz"
  sha256 "0c751b489749fbf02071d5b0c6bfeb26c4b863c668ef89711ecf9507391bdf71"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b6cc49ffbee4dda141485c8306bcab7781d63048b65aeb485b0963dda4430ce9"
    sha256 cellar: :any,                 arm64_sonoma:  "ae084a265c8531b9ac0fbbe9b00da80b4b622c41caf1aa091b5a010eb2185ae4"
    sha256 cellar: :any,                 arm64_ventura: "9b1f5819ae43705b7afe994b4de6ef027b2fb1f09ad89d713be29cc0d52102af"
    sha256 cellar: :any,                 ventura:       "8c5337b31e6145007ec1d742ebaf6a41122f5730ec804fa9f253b0ba59a41f4b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "42aec4181cb92ef2910ccf4c0738c934258940b90f50945d92881dea581d2124"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "274fd1b12b7a1984f724c46ea83cf50a86f228845246660b1e213e4e1e17d019"
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
