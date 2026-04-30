# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT86 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-2.0.10.tgz"
  sha256 "1fd5e074dacf5149603493c454b476d69850bec0a71d7ea69a36a00db728a0fb"
  revision 1
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6b983d4ecd8d169fd57e12fdfffe3fa1a8dbab91bb2b472c91295536d2142a6e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "057a7375469c4bf8fd3c0f9c7e08416a3697bed22795085754601254dbde3608"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8fee97882fa737b616566d82fddb82804040648a7be0412d2af464fd29a278e2"
    sha256 cellar: :any_skip_relocation, sonoma:        "634f9c58b05a4f11d87a5f6b9a79dbd887a9e813fb4a79c28c2a97bc18645b86"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a5d642087d4338410a72420b8409fe0689d87135abea2b1d69e36e12c8c88bce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7376f064891adfd32c4d85237735580267bdd97da2f440cc0383340176e9abfe"
  end

  depends_on "curl"

  def install
    Dir.chdir "oauth-#{version}"
    Dir["**/*.{c,h}"].each do |f|
      next unless File.read(f).include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof"
        s.sub!(/\A/, "#include <stddef.h>\n")
      end
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-oauth"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
