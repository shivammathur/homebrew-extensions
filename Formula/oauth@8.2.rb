# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT82 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-2.0.10.tgz"
  sha256 "1fd5e074dacf5149603493c454b476d69850bec0a71d7ea69a36a00db728a0fb"
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "59b97557084077030de04b40810b765992520ee14e989538c28a30a524a1591e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "77ecc0d40e75d09143291ca37a25f479202bad96d517b01e36f57fa54b40f836"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d1b20d8ff7f4e109df183cf592196c6c4e6e42b3bcf187ddd78b51ff52475f87"
    sha256 cellar: :any_skip_relocation, sonoma:        "7cea20581bde6be51c19e1a669e40297f0dce45e95cc06dce2191fc66afb2158"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6fde063880c38a0a058ae775838d4f1415a864e40b5f200099841115a9487671"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d64acc24ad2c32b5615cbd5c61f7270f0fcc58ab03ee9a5240824586528dca4b"
  end

  depends_on "curl"

  def install
    Dir.chdir "oauth-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-oauth"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
